FROM python:3.12-alpine as base
FROM base as builder
COPY requirements.txt /requirements.txt
RUN pip install --user -r /requirements.txt

FROM base
COPY --from=builder /root/.local /root/.local
COPY . /app
RUN rm -rf .git* *.md *.txt
WORKDIR /app
RUN ls -la

# update PATH environment variable
ENV PATH=/home/app/.local/bin:$PATH

EXPOSE 5000
CMD ["python", "-u", "main.py"]
