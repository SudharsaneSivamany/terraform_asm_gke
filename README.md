## Description of this Terraform code

This repo is used to create the below resource in gcp,
- ASM enabled Private GKE cluster
- Cloud NAT and Router
- Cloud Armor
- Kubernetes manifest for sample app deployment

## Prerequisites
1. Requires VPC to be created in the project
1. Requires following apis to be enabled.
   - compute.googleapis.com
   - cloudresourcemanager.googleapis.com
   - gkehub.googleapis.com
   - container.googleapis.com
   - mesh.googleapis.com

## Create static IP address

```bash
gcloud compute addresses create --global gke-public-ip
```

## Create ssl policy

```bash
gcloud compute ssl-policies create gke-ingress-ssl-policy --profile MODERN --min-tls-version 1.2
```
