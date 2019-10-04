# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'send message', type: :feature do
  let(:room) { Room.first }
  let(:sender) { room.users.first }
  let(:receiver) { room.users.last }
  let(:test_message_content) { 'test_message' }

  context 'from senders view' do
    before do
      Support::SignUp.new(@browser).call({:email => sender.email, :password => '123456'})
      chat_page = ChatPage.new(room.id, @browser)
      chat_page.send_message(test_message_content)
    end
    it 'message should be sent' do
      browser.text.should match(/.*#{test_message_content}.*/)
    end
  end

  context 'from receivers view' do
    before do
      Support::SignUp.new(@browser).call({:email => sender.email, :password => '123456'})
      chat_page = ChatPage.new(room.id, @browser)
    end
    it 'message should be received' do
      browser.text.should match(/.*#{test_message_content}.*/)
    end
  end
  after(:context) do
    Message.last.destroy
  end
end
