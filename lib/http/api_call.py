import re
import json
from response import ApiResponse, HtmlResponse, JsonResponse
from requests import get, post, head, Response
from typing import Callable, Dict, Optional


class ApiCall:
    endpoint: str
    format: str
    headers: Optional[Dict]
    method_str: str
    method: Callable[..., Response]

    def __init__(self, args) -> None:
        self.endpoint = self._scheme_endpoint(args.endpoint)
        self.format = args.format
        self.headers = json.load(args.headers) if args.headers is not None else None
        self.method_str = args.method
        self.method = self._map_method(args.method)

    def _scheme_endpoint(self, endpoint: str) -> str:
        """Add a scheme to the endpoint in case none was provided (allows shorter syntax)"""
        if re.search("^https?:\/\/.*", endpoint) is not None:
            return endpoint

        return f"https://{endpoint}"

    def _map_method(self, method: str) -> Callable[..., Response]:
        m = {
            "get": get,
            "post": post,
            "head": head
        }

        return m.get(method)

    def send(self) -> ApiResponse:
        res = self.method(self.endpoint)

        # .json() doesn't work when sending head requests
        # bit of a hack but meh
        if self.method_str == "head":
            res.json = lambda: dict(res.headers)

        if self.format == "html":
            return HtmlResponse(res)
        elif self.format == "json":
            return JsonResponse(res)
