resource "aws_efs_mount_target" "mount_target_public_a" {
  file_system_id  = aws_efs_file_system.foo.id
  subnet_id       = var.subnet_public_id_a
  security_groups = [var.security_group_efs_id]
}

resource "aws_efs_mount_target" "mount_target_public_b" {
  file_system_id  = aws_efs_file_system.foo.id
  subnet_id       = var.subnet_public_id_b
  security_groups = [var.security_group_efs_id]
}


