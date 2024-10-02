resource "local_file" "hosts_yml" {
  depends_on = [
    yandex_compute_instance.masters,
    yandex_compute_instance.workers,
    yandex_compute_instance.nat-instance,
  ]
  content = templatefile("${path.module}/hosts.tftpl",
    {
      masters = yandex_compute_instance.masters[*],
      workers  = yandex_compute_instance.workers[*],
      nat-instance = yandex_compute_instance.nat-instance,
    })
  filename = "${path.module}/../ansible/hosts.yml"
}

resource "null_resource" "install-k8s" {
  depends_on = [
    yandex_compute_instance.masters,
    yandex_compute_instance.workers,
    yandex_compute_instance.nat-instance,
  ]

  provisioner "local-exec" {
    command = "rm -rf ${path.module}/../ansible/kubespray && git clone https://github.com/kubernetes-sigs/kubespray.git ${path.module}/../ansible/kubespray"
  }  

  provisioner "local-exec" {
    command = "python3 -m pip install -r ${path.module}/../ansible/kubespray/requirements.txt"
  }  


  provisioner "local-exec" {
    command = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${path.module}/../ansible/hosts.yml -b ${path.module}/../ansible/install-k8s.yml"
  }
}

resource "null_resource" "copy-config-k8s" {
  triggers = {
    always_run = "${timestamp()}"
  }
  depends_on = [
    yandex_compute_instance.masters,
    yandex_compute_instance.workers,
    yandex_compute_instance.nat-instance,
    null_resource.install-k8s,
  ]

  provisioner "local-exec" {
    command = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${path.module}/../ansible/hosts.yml ${path.module}/../ansible/copy-config.yml"
  }
}
