variable "GCP_PROJECT_ID" {
  description = "Project ID"
  type        = string
}

variable "GOOGLE_CREDENTIALS" {
  description = "GOOGLE_CREDENTIALS"
  type        = string
}

variable "AppName" {
  description = "App Name"
  type        = string
  default = "gh-actions-demo"
}

variable "Location" {
  description = "Localtion"
  type        = string
  default = "asia-southeast1"
}


