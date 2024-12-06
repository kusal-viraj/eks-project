resource "aws_volume_attachment" "ebs_attachment" {
  device_name = "/dev/sdh"
  volume_id   = var.volume_id
  instance_id = var.instance_id
}
