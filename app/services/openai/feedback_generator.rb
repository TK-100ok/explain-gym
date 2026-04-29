module Openai
  class FeedbackGenerator
    def self.call(training)
      new(training).call
    end

    def initialize(training)
      @training = training
    end

    def call
      client = OpenAI::Client.new

      response = client.chat(
        parameters: {
          model: "gpt-4.1-mini",
          messages: messages,
          response_format: { type: "json_object" },
          temperature: 0.5
        }
      )

      raw = response.dig("choices", 0, "message", "content")
      JSON.parse(raw)
    end

    private

    attr_reader :training

    def messages
      [
        {
          role: "system",
          content: "あなたは優秀なコーチです。ユーザーの説明に対して、分かりやすく具体的にフィードバックしてください。"
        },
        {
          role: "user",
          content: build_prompt
        }
      ]
    end

    def build_prompt
      <<~TEXT
      以下の説明に対してフィードバックをしてください。

      必ず以下のJSON形式で返してください。

      {
        "good_points": "良い点",
        "improvement_points": "改善点",
        "overall_comment": "総評",
        "score": 0〜100の整数
      }

      テーマ: #{training.theme}
      相手: #{training.target&.name || training.custom_target}
      説明:
      #{training.explanation}
      TEXT
    end
  end
end
