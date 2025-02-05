provider "aws" {
  region = "ap-south-1"  
}

provider "vault" {
  address = "http://172.22.21.143:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "d9d18413-a0c2-a141-b496-fc021da898c9"
      secret_id = "b5f94bed-11f5-fa8d-52f0-bdefe9e71a2a"
    }
  }
}

data "vault_kv_secret_v2" "example" {
  mount = "kv" // change it according to your mount
  name  = "my-tf-sec" // change it according to your secret
}

resource "aws_s3_bucket" "name" {
    bucket = data.vault_kv_secret_v2.example.data["name"]
  
}

output "name" {
  value = aws_s3_bucket.name.bucket
}