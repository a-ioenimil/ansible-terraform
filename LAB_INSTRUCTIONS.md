# Lab Instructions

## Prerequisites
1. **AWS CLI**: configured with `aws configure`.
2. **Session Manager Plugin**: installed on your local machine for the Session Manager to work.
3. **Terraform**: installed (v1.5+).
4. **Ansible**: installed (v2.14+).
5. **Python Dependencies**:
   ```bash
   pip install boto3 botocore
   ansible-galaxy collection install amazon.aws community.docker
   ```

## Execution Steps

### 1. Infrastructure Provisioning (Terraform)
Navigate to the `infra` directory:
```bash
cd infra
```

Initialize Terraform:
```bash
terraform init
```

Plan and Apply (logging output to APPLY.txt):
```bash
terraform plan -out=tfplan
terraform apply tfplan | tee ../APPLY.txt
```
*Note: Type `yes` if prompted (though passing the plan should auto-approve).*

This step will:
- Create the EC2 instance, Security Group, and IAM roles.
- Automatically generate `../ansible/inventory.ini` with the Instance ID.

### 2. Configuration Management (Ansible)
Navigate to the `ansible` directory:
```bash
cd ../ansible
```

Verify connection (via SSM):
```bash
ansible -m ping webservers
```

Run the Playbook:
```bash
ansible-playbook site.yml
```

### 3. Verification
1. Get the public IP from the Terraform output:
   ```bash
   cd ../infra
   terraform output public_ip
   ```
2. Open `http://<PUBLIC_IP>` in your browser. You should see the Nginx Demo page.
3. Take a screenshot.

Alternatively, verify via curl:
```bash
curl http://<PUBLIC_IP>
```

### 4. Teardown
Clean up the resources (logging to DESTROY.txt):
```bash
terraform destroy -auto-approve | tee ../DESTROY.txt
```

## Professional Architecture Notes
- **Security**: No SSH keys were generated. Access is purely via AWS Systems Manager (SSM). Port 22 is closed.
- **Networking**: Only Port 80 is open to the world.
- **Idempotency**: The Ansible playbook is designed to be safe to re-run.
