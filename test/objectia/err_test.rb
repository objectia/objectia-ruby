require_relative "./helper"

module ObjectiaTest
  class ObjectiaErrTest < ObjectiaTest::Test

    def test_response_error
      begin
        raise Objectia::ResponseError.new("Not found", 404, "err-not-found")
      rescue Objectia::ResponseError => e
        assert_equal "Not found", e.message
        assert_equal 404, e.status
        assert_equal "err-not-found", e.code
      end
    end

  end
end