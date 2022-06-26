terraform { 
  required_providers {
     aws = {
	source = "hashicorp/aws"
	version = "~> 4.16"
  } 
 }
}

provider "aws" {
   region = "us-east-2"
   access_key = "AKIAXYFS7PGJSP4VJ3NP"
   secret_key = "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"
}
