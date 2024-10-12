
resource "aws_instance" "linux_frodas" {
    ami = "ami-07dd19a7900a1f049"
    instance_type = "t3.micro"

    key_name = "terraform-keypair"
    vpc_security_group_ids = ["sg-0d5a6583b8af4e5d8ndasn"]
    tags = {
        Name = "Linux"
    }
}

resource "aws_instance" "windows_frodas" {
    ami = "ami-0sdxxxxxxxxx"
    instance_type = "t3.micro"

    tags = {
        Name = "Windows"
    }
}

