# Use the original image as a base
FROM informaticsmatters/rdkit-python3-debian

# Switch to root user for installations
USER root

# Install necessary packages and JupyterLab
RUN apt-get update && apt-get install -y python3-pip
RUN pip3 install jupyterlab

# Switch back to non-root user (replace "username" with the original user)
# USER username

# Copy the script into the image
COPY start_jupyter.sh /home/

# Make the script executable
RUN chmod +x /home/start_jupyter.sh

# Expose JupyterLab port
EXPOSE 8888

# Start JupyterLab when container is run
CMD ["./home/start_jupyter.sh"]
