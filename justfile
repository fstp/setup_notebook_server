alias lab := start_jupyter

build:
    terraform apply -auto-approve

destroy:
    terraform destroy -auto-approve

install:
    ./create_inventory.sh
    ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory --private-key ~/.ssh/lambda_labs playbook.yaml

ssh:
    ssh -i ~/.ssh/lambda_labs ubuntu@$(./create_inventory.sh)

# You only need to run this once to set up the kernel and ipywidgets extension
setup_jupyter:
    . venv/bin/activate && python -m ipykernel install --user --name=venv
    . venv/bin/activate && jupyter labextension install @jupyter-widgets/jupyterlab-manager

start_jupyter:
    . venv/bin/activate && jupyter lab --no-browser --port=8888 --notebook-dir=./

upload:
    rsync -arvzP -e "ssh -i ~/.ssh/lambda_labs" ./notebooks ubuntu@$(cat inventory):/home/ubuntu

download:
    rsync -arvzP -e "ssh -i ~/.ssh/lambda_labs" ubuntu@$(cat inventory):/home/ubuntu/notebooks ./
