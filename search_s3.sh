#!/bin/bash

# Set the S3 bucket name
bucket_name="topcasinosukcouk"

# Set the path to the file containing the list of page paths
page_list_file="page_list.txt"

# Iterate over each page path in the list
while IFS= read -r page_path; do
    # Remove leading and trailing whitespace from the page path
    page_path=$(echo "$page_path" | xargs)

    # Use the AWS CLI to check if the page exists in the S3 bucket
    aws s3 ls "s3://$bucket_name/$page_path" >/dev/null 2>&1

    # Check the exit code of the previous command
    if [[ $? -eq 0 ]]; then
        echo "Page $page_path found in S3 bucket."
    else
        echo "Page $page_path not found in S3 bucket."
    fi
done < "$page_list_file"
