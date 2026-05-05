# FastAPI Health Demo

Minimal FastAPI application with health check endpoint.

## Dependencies

- Python 3.11+
- FastAPI
- Uvicorn (for running the server)
- Pytest (for running tests)

## Installation

Install dependencies:

```bash
pip install fastapi uvicorn pytest httpx
```

## Running the Application

Start the FastAPI server:

```bash
cd app
python main.py
```

Or using uvicorn directly:

```bash
uvicorn app.main:app --host 0.0.0.0 --port 8000
```

The server will be available at `http://localhost:8000`

## API Endpoints

### Health Check

**GET** `/health`

Returns:
```json
{
  "status": "ok",
  "env": "dev"
}
```

## Running Tests

Run tests with pytest:

```bash
pytest tests/test_health.py -v
```

Or:

```bash
python -m pytest tests/test_health.py -v
```

## Development

The application uses:
- FastAPI for the web framework
- Uvicorn as the ASGI server
- Pytest for testing