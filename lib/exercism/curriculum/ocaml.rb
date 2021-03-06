class Exercism
  class OcamlCurriculum
    def slugs
      # Pretty simple
      %w(
        bob word-count anagram beer-song nucleotide-count
        rna-transcription point-mutations phone-number
        grade-school space-age) +

      # Somewhat tricky
      %w(
        prime-factors
      ) +

      # Rather complicated
      %w(
        zipper
      )
    end

    def language
      'ocaml'
    end
  end
end
