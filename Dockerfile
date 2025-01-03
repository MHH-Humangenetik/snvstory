# Use python 3.9 slim as the base image
FROM python:3.9-slim-bookworm

# IUnstall uv (https://docs.astral.sh/uv/)
COPY --from=ghcr.io/astral-sh/uv:0.5.13 /uv /uvx /bin/

# Install the tool and required dependencies
COPY . /app/
WORKDIR /app
RUN uv sync --frozen --no-dev --compile-bytecode

# Add the virtualenv at the front of the PATH to ensure using the correct Python version
ENV PATH="/app/.venv/bin:$PATH"

# default to running the tool
CMD ["uv", "run", "python", "igm_churchill_ancestry", " --resource", "./resource_dir"]