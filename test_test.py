import unittest
import json
from http.server import HTTPServer
from threading import Thread
import http.client
from test import RequestHandler


class TestServer(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        # Start the server in a separate thread
        cls.server = HTTPServer(('localhost', 8080), RequestHandler)
        cls.thread = Thread(target=cls.server.serve_forever)
        cls.thread.start()

    @classmethod
    def tearDownClass(cls):
        # Shutdown the server
        cls.server.shutdown()
        cls.thread.join()

    def test_post_prompt(self):
        # Create a connection to the server
        conn = http.client.HTTPConnection('localhost', 8080)
        # Define the prompt
        prompt = "Tell me a fun fact about space."
        # Create the JSON payload
        payload = json.dumps({'prompt': prompt})
        # Send a POST request
        conn.request('POST', '/', payload, headers={'Content-Type': 'application/json'})
        # Get the response
        response = conn.getresponse()
        # Read the response content
        response_content = response.read().decode('utf-8')
        # Check if the response status is 200
        self.assertEqual(response.status, 200)
        # Check if the response content is not empty
        self.assertTrue(len(response_content) > 0)


if __name__ == '__main__':
    unittest.main()
