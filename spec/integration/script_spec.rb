require 'spec_helper'

describe 'get favorite language' do

  let(:github_user) { 'tevio' }
  let(:cmd) { "ruby ../../script.rb #{github_user}" }

  it 'returns my favorite language' do
    command = run_interactive(cmd)
    timeout_command(command)
    assert_exact_output(':Ruby\n', command.stdout)
  end

  context 'with a different username' do
    let(:github_user) { 'torvalds' }

    it "returns Linus' favorite language" do
      command = run_interactive(cmd)
      timeout_command(command, 20)
      assert_exact_output(':C\n', command.stdout)
    end
  end

  context 'with a fake username' do
    let(:github_user) { 'asdfjasdfjasdfkfaeskasdfkasdfkasdlfaldsfasdfjasdf' }

    it 'returns nil' do
      command = run_interactive(cmd)
      timeout_command(command, 3)
      assert_exact_output('', command.stdout)
    end
  end

  def timeout_command(command, seconds = 10)
    timer = 0
    while command.stdout == ''
      sleep 1
      timer += 1
      break if timer == seconds
    end
  end
end

