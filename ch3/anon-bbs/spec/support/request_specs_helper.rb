module RequestSpecsHelper
  def expect_to_conform_schema(response)
    expect { @schema.validate!(JSON.parse(response.body)) }.not_to raise_error
  end
end
