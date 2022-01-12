from abc import ABC, abstractmethod
from typing import Callable, Optional
from bs4 import BeautifulSoup as BS
import json
from requests import Response


class ApiResponse(ABC):
    response: Response

    def __init__(self, response: Response) -> None:
        super().__init__()
        self.response = response

    @abstractmethod
    def prettify(self) -> str:
        pass

    def status_code(self) -> int:
        return self.response.status_code


class HtmlResponse(ApiResponse):
    def prettify(self) -> str:
        return BS(self.response.text, "html.parser").prettify()


class JsonResponse(ApiResponse):
    def prettify(self) -> str:
        return json.dumps(self.response.json(), indent=4, sort_keys=False)
