from fastapi.testclient import TestClient

from app.main import app

client = TestClient(app)


def test_health_endpoint_returns_ok() -> None:
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok", "env": "dev"}


def test_health_endpoint_response_format() -> None:
    response = client.get("/health")
    body = response.json()
    assert set(body.keys()) == {"status", "env"}
    assert body["status"] == "ok"
    assert body["env"] == "dev"


def test_health_endpoint_content_type_is_json() -> None:
    response = client.get("/health")
    assert response.headers["content-type"].startswith("application/json")