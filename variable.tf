variable "mistral_api_key" {
    type = string
    description = "Clé API Mistral"
    sensitive = true
}

variable "best_company" {
    description = "best company in the world"
    type = string
    default = "Mistral AI"
}