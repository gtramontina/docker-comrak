FROM rust:1.53-slim as build
ARG version
WORKDIR /opt
RUN rustup target add x86_64-unknown-linux-musl
RUN cargo install \
	--target x86_64-unknown-linux-musl \
	--root /opt \
	--version $version \
	comrak

# ---

FROM scratch
COPY --from=build /opt/bin/comrak /comrak
ENTRYPOINT ["/comrak"]
