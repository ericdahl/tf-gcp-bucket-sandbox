# tf-gcp-bucket-sandbox

```
terraform apply

# test different permissions
$ gcloud auth activate-service-account --key-file credentials_read_only.json

$ gsutil ls gs://tf-gcp-bucket-sandbox
gs://tf-gcp-bucket-sandbox/hello.txt




# switch to read-write account

$ gcloud auth activate-service-account --key-file credentials_read_write.json 

$ gsutil cp ~/hello2.txt gs://tf-gcp-bucket-sandbox

```