from flask import render_template
from app import app
import os

@app.route('/')
def index():
    # Retrieve environment variables
    username = os.getenv("USERNAME", "default_user")
    container_name = os.getenv("CONTAINER_NAME", "default_container")
    port_no = os.getenv("PORT_NO", "5000")
    gpu = os.getenv("GPU", "NO")
    memory = os.getenv("MEMORY", "1G")
    cpu = os.getenv("CPU", "1")

    return render_template('index.html', username=username, container_name=container_name, port_no=port_no, gpu=gpu,memory=memory, cpu=cpu)
