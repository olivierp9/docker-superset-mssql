# Specify the version of amancevice/superset you are using.
# Replace 'latest' with a specific version tag if needed, e.g., 4.0.1
ARG SUPERSET_VERSION=latest
FROM amancevice/superset:${SUPERSET_VERSION}

# Switch to root user to install system dependencies
USER root

# Update package lists, install FreeTDS development headers and a C compiler (required by pymssql),
# then clean up apt cache to keep the image smaller.
RUN apt-get update && \
    apt-get install -y --no-install-recommends freetds-dev gcc libc-dev && \
    rm -rf /var/lib/apt/lists/*

# Install pymssql using pip
RUN pip install pymssql

# Switch back to the superset user
USER superset