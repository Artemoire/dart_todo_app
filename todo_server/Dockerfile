# Use latest stable channel SDK.
FROM dart:stable AS build

# Setup app
WORKDIR /app
COPY todo_server/pubspec.* ./todo_server/
COPY todo ./todo
COPY rawdog ./rawdog

# Resolve app dependencies.
WORKDIR /app/todo_server
RUN dart pub get

# Copy app source code (except anything in .dockerignore) and AOT compile app.
COPY todo_server/. .

RUN dart compile exe bin/todo_server.dart -o bin/server

# Build minimal serving image from AOT-compiled `/server`
# and the pre-built AOT-runtime in the `/runtime/` directory of the base image.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/todo_server/bin/server /app/bin/

# Set the working directory
WORKDIR /app/bin

# Start server.
EXPOSE 8080
CMD ["/app/bin/server"]
