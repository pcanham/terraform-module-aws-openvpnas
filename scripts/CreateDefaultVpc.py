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


def check_for_vpc():
    """
    Check to see whether default VPC exists
    """
    try:
        response = vpc_client.describe_vpcs(
            Filters=[
                {"Name": "isDefault", "Values": ["true"]},
            ]
        )
    except ClientError:
        logger.exception("Could not find default vpc.")
        pass
    else:
        return response


if __name__ == "__main__":
    logger.info("Checking for default VPC...")
    check_vpc = check_for_vpc()
    logger.info(check_vpc)

    try:
        logger.info(f"Default VPC is created with VPC ID: {check_vpc['Vpc']["VpcId"]}")
    except KeyError:
        logger.info("Creating default VPC...")
        default_vpc = create_default_vpc()
        logger.info(
            f"Default VPC is created with VPC ID: {default_vpc["Vpc"]["VpcId"]}"
        )
