FROM us-docker.pkg.dev/bendory-cloud-builders/cloud-builders/python
COPY listbuilds.py .
RUN pip install google-cloud-build
ENTRYPOINT ["python3", "listbuilds.py"]
