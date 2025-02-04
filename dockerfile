FROM spark:3.5.4-scala2.12-java11-ubuntu

USER root

RUN set -ex; \
    apt-get update; \
    apt-get install -y python3 python3-pip; \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Install Jupyter
# RUN pip3 install jupyter

# Verify Jupyter installation
RUN jupyter --version

# Copy the application code
COPY . .

# Set the entrypoint to run the Jupyter notebook
ENTRYPOINT ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--no-browser"]