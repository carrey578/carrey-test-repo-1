from fastapi import FastAPI


app = FastAPI(title="Env5 Health Demo")


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok", "env": "dev"}
