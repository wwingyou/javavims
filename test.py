from openai import OpenAI
from http.server import BaseHTTPRequestHandler, HTTPServer

client = OpenAI()


class RequestHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        # Determine the length of the data
        content_length = int(self.headers['Content-Length'])
        # Read the data from the request
        post_data = self.rfile.read(content_length)
        # Parse the JSON data to get the prompt
        import json
        data = json.loads(post_data)
        prompt = data.get('prompt', '')
        # Generate completion using OpenAI API with the prompt from the request body
        completion = client.chat.completions.create(
            model="gpt-4o",
            messages=[{
                "role": "user",
                "content": prompt
            }]
        )

        # Get the content of the completion
        response_content = completion.choices[0].message.content

        # Send response status code
        self.send_response(200)

        # Send headers
        self.send_header('Content-type', 'text/plain')
        self.end_headers()

        # Write content as response body
        self.wfile.write(response_content.encode('utf-8'))


def run(server_class=HTTPServer, handler_class=RequestHandler, port=8080):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print(f'Starting httpd server on port {port}')
    httpd.serve_forever()


if __name__ == "__main__":
    run()
