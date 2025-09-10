ExUnit.start()

Mox.defmock(EmiCore.MetadataFetcher.MockFetcher, for: EmiCore.MetadataFetcher.Fetcher)
Application.put_env(:emi_core, :make_request, EmiCore.MetadataFetcher.MockFetcher)
