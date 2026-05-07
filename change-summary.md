# Change Summary

## Version 1.0.0 (2026-05-05)

### Added

- **app/main.py**: Minimal FastAPI application with `/health` endpoint
  - Returns `{"status": "ok", "env": "dev"}` on GET request to `/health`
  - Exposes `app` for local development with `uvicorn app.main:app`

- **tests/test_health.py**: Test suite for health endpoint
  - `test_health_endpoint_returns_ok`: Verifies correct status code and response body
  - `test_health_endpoint_response_format`: Validates JSON response format
  - `test_health_endpoint_content_type_is_json`: Verifies JSON content type

- **README.md**: Running instructions and documentation
  - Installation steps for dependencies
  - Commands to start the server
  - API endpoint documentation
  - Test execution instructions

### Configuration

- Python 3.11+ required
- Dependencies: fastapi, uvicorn, pytest, httpx
- Server can be run with `uvicorn app.main:app --host 0.0.0.0 --port 8000`

### Notes

- This is a minimal demo for health check functionality
- Environment is hardcoded to "dev" for demonstration purposes
- No authentication or secrets required
