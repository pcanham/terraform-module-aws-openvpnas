import logging
import boto3
from botocore.exceptions import ClientError

AWS_REGION = "eu-west-1"
ENDPOINT_URL = "http://localstack:4566"

# logger config
logger = logging.getLogger()
logging.basicConfig(
    level=logging.INFO, format="%(asctime)s: %(levelname)s: %(message)s"
)

vpc_client = boto3.client("ec2", region_name=AWS_REGION, endpoint_url=ENDPOINT_URL)


def create_default_vpc():
    """
    Creates a default VPC in the configured availability zone.
    """
    try:
        response = vpc_client.create_default_vpc()
    except ClientError:
        logger.exception("Could not create default vpc.")
        pass
    else:
        return response


def check_for_vpc(vpc_client):
    """
    Check to see whether default VPC exists
    """
    logger.info("Checking for default VPC...")
    filters = [{'Name': 'isDefault', 'Values': ['true']}]
    vpcs = vpc_client.describe_vpcs(Filters=filters)['Vpcs']
    return len(vpcs) > 0


if __name__ == "__main__":
    if has_default_vpc(vpc_client):
        logger.info("Has default VPC. Skipping creation.")
        response = vpc_client.describe_vpcs(
            Filters=[
                {"Name": "isDefault", "Values": ["true"]},
            ]
        )
        return default_vpc["Vpc"]["VpcId"]

    logger.info("Creating default VPC...")
    default_vpc = create_default_vpc()
    logger.info(
        f"Default VPC is created with VPC ID: {default_vpc["Vpc"]["VpcId"]}"
    )
