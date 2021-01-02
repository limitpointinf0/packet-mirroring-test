# Getting Started With Packet Mirroring in GCP
Testing the packet mirroring feature of GCP

## Steps
- Setup the infrastructure with Terraform
```bash
terraform init

terraform plan

terraform apply
```

- Create an SSH key-pair on the wild instance and share the public key with the recipient instance

- Go to Packet Mirroring in the GCP console and make sure the following are set:
    - mirrored source: sender VM
    - load balancer:
        - set instance group for backend as terraform-packet-mirrors with check TCP as healthcheck
        - set subnet for frontend
        - create

- Open a 2 terminal windows on your local machine:

terminal 1
```bash
ssh `terraform output wild-ip`
ssh [private_IP_of_recipient_vm]
sudo tcpdump port not 22
```  

terminal 2
```bash
ssh `terraform output sender-ip`
ping 1.1.1.1
```  
- Check the packet stream in the recipient vm.


## Sources
[GCP Packet Mirroring - From Zero to Pcap](https://www.youtube.com/watch?v=cg_fbDC4l9w)
## License
[MIT](https://choosealicense.com/licenses/mit/)