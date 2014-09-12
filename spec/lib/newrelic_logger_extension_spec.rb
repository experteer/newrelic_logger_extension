require 'logger'

module NewRelic
end
describe NewrelicLoggerExtension do
  SPEC_LOG_PATH = 'tmp/newrelic_logger_extension_spec.log'
  let(:logger) { Logger.new(SPEC_LOG_PATH) }
  after(:each) do
    File.delete(SPEC_LOG_PATH)
    ::NewRelic.send(:remove_const, 'Agent')
  end

  before(:each) do
    ::NewRelic::Agent = double('Agent', increment_metric: true)
    NewrelicLoggerExtension.inject_logger(logger, 'warn')
  end

  it 'should not interfere with the actuall logging' do
    logger.warn('test warning')
    filelog = IO.read(SPEC_LOG_PATH)
    expect(filelog).to match 'WARN -- :'
    expect(filelog).to match 'test warning'
  end
  it 'should call :increment_metric on the NewRelic::Agent' do
    expect(::NewRelic::Agent).to receive(:increment_metric)
    logger.warn('test warning')
  end
  it 'should call correctly set the custom metric nameing' do
    expect(::NewRelic::Agent)
      .to receive(:increment_metric)
         .with('Custom/Warn/spec__lib__newrelic_logger_extension_spec__32')
    logger.warn('test warning') # this is line 32
  end
end
