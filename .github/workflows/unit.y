name: Unit Tests
on: push
jobs:
  go-tests:
    name: Run Go Unit Tests
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - uses: actions/setup-go@v1
        with:
          go-version: 1.13
      - uses: autero1/action-terraform@v0.1.0
        with:
          terraform_version: 0.12.21
      - name: Download Go Modules
        working-directory: test
        run: go mod download
      - name: Run Go Tests
        working-directory: test
        run: go test -v -tags=unit
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.aws_access_key_id }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.aws_secret_access_key }}