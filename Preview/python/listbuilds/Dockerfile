FROM us-docker.pkg.dev/cloud-builders/preview/python
COPY listbuilds.py .
RUN pip install google-cloud-build google-auth
ENTRYPOINT ["python3", "listbuilds.py"]
