# frozen_string_literal: true

require 'net/http'
require 'nifcloud/client'
require 'spec_helper'

RSpec.describe Nifcloud::Client do # rubocop:disable Metrics/BlockLength
  let(:access_key) { 'dummy_access_key' }
  let(:secret_key) { 'dummy_secret_key' }
  let(:client) { described_class.new(access_key, secret_key) }
  let(:path) { 'test/path' }
  let(:body_xml) { '<Response><Result>OK</Result></Response>' }
  let(:parsed_xml) { { 'Result' => ['OK'] } }
  let(:http_response) do
    instance_double(Net::HTTPSuccess, body: body_xml, code: '200')
  end

  before do
    allow_any_instance_of(Nifcloud::Client).to receive(:signature_header).and_return('signed-header')
    allow_any_instance_of(Nifcloud::Client).to receive(:instance_variable_set)
    return_time = '2025-05-16T12:00:00Z'
    allow_any_instance_of(Nifcloud::Client).to receive(:instance_variable_get).with(:@time).and_return(return_time)

    http = instance_double(Net::HTTP)
    allow(Net::HTTP).to receive(:new).and_return(http)
    allow(http).to receive(:use_ssl=)
    allow(http).to receive(:request).and_return(http_response)
  end

  describe '#get' do
    it 'sends a GET request and parses the response' do
      expect(Net::HTTP::Get).to receive(:new).with(anything).and_call_original
      res = client.get(path)
      expect(res.body).to eq(parsed_xml)
      expect(res.code).to eq('200')
      expect(res.raw).to eq(body_xml)
    end
  end

  describe '#post' do
    let(:request_body) { '<Request><Action>Test</Action></Request>' }
    it 'sends a POST request with body and parses the response' do
      expect(Net::HTTP::Post).to receive(:new).with(anything).and_call_original
      res = client.post(path, request_body)
      expect(res.body).to eq(parsed_xml)
      expect(res.code).to eq('200')
      expect(res.raw).to eq(body_xml)
    end
  end

  describe '#delete' do
    it 'sends a DELETE request and parses the response' do
      expect(Net::HTTP::Delete).to receive(:new).with(anything).and_call_original
      res = client.delete(path)
      expect(res.body).to eq(parsed_xml)
      expect(res.code).to eq('200')
      expect(res.raw).to eq(body_xml)
    end
  end
end
