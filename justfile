build:
    terraform apply -auto-approve

destroy:
    terraform destroy -auto-approve

install:
    ./create_inventory.sh
    ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory --private-key ~/.ssh/lambda_labs playbook.yaml

ssh:
    ssh -i ~/.ssh/lambda_labs ubuntu@$(./create_inventory.sh)

start_jupyter:
    . venv/bin/activate && jupyter lab --no-browser --port=8888 --notebook-dir=./notebooks

upload:
    rsync -vz -e "ssh -i ~/.ssh/lambda_labs" ./notebooks ubuntu@$(cat inventory):/home/ubuntu
