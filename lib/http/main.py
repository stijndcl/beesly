import argparse
from api_call import ApiCall
from response import ApiResponse


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("endpoint", type=str, help="The endpoint to send the request to.")
    parser.add_argument("-m", "--method", help="The HTTP method to use for this request.", default="get", choices=["get", "head", "post"], type=str.lower)
    parser.add_argument("-f", "--format", help="The requested responses format.", default="json", choices=["html", "json"], type=str.lower)
    parser.add_argument("--headers", help="Header to attach to the request.", default=None, type=str)
    parser.add_argument("--no-status", help="Don't print the status code at the  end. Useful when trying to store the response in a file to re-use it later on.", action="store_true")
    args = parser.parse_args()

    response: ApiResponse = ApiCall(args).send()
    print(response.prettify())

    if not args.no_status:
        print(f"\nStatus code: {response.status_code()}")
