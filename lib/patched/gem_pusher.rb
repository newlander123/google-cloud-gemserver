# Copyright 2017 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#  https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "gemstash"
require "google/cloud/gemserver"

module PatchedGemPusher
  ##
  # Monkeypatch to run a gem syncing service in the background after pushing a
  # gem to the gemserver.
  def serve
    super
    Google::Cloud::Gemserver::Backend::StorageSync.run
  end
end

Gemstash::GemPusher.send :prepend, PatchedGemPusher
