# frozen_string_literal: true

require 'rails_helper'

class CommandTest
  include Command

  attr_reader :test

  def initialize(test = 'test')
    @test = test
    super()
  end

  protected

  def perform
    true
  end
end

class CommandTestWrong
  include Command

  def initialize
    super()
  end
end

RSpec.describe CommandTest do
  describe 'initialize methods' do
    subject { CommandTest.new }

    it 'initialize global variables of class' do
      subject
      expect(subject.test).to eq('test')
    end

    it 'module call perform method of class' do
      expect_any_instance_of(CommandTest).to receive(:perform)
      subject
    end
  end

  describe 'class not implements peform method' do
    it { expect { CommandTestWrong.new }.to raise_error("method 'perform' not implemented for this class") }
  end

  describe 'instance has command att_readers' do
    subject { CommandTest.new }
    context 'when result succeed' do
      it '.result' do
        expect(subject.result).to be_truthy
      end

      it '.errors' do
        expect(subject.errors).to be_falsey
      end

      it '.success?' do
        expect(subject.success?).to be_truthy
      end
    end

    context 'when result succeed' do
      before do
        allow_any_instance_of(CommandTest).to receive(:errors).and_return(['Errors'])
        allow_any_instance_of(CommandTest).to receive(:perform).and_return(nil)
      end
      it '.result' do
        expect(subject.result).to be_falsey
      end

      it '.errors' do
        expect(subject.errors).to eq(['Errors'])
      end

      it '.success?' do
        expect(subject.success?).to be_falsey
      end
    end
  end
end
