terraform {
  backend "s3" {
    bucket = "remotebackendserver"
    key    = "terraform.tfstate"
    region = "ap-south-2"
    use_lockfile = true
  }
}
