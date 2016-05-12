node(:meta) { 
    #response.status
    {
        status: "successfully",
        code: 200
    }
  }
node(:data) do
  Yajl::Parser.parse(yield)
end