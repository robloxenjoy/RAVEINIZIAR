import { exhaustiveCheck } from "common/exhaustive";
import { useBackend, useLocalState } from "../../backend";
import { Button, Stack } from "../../components";
import { Window } from "../../layouts";
import { PreferencesMenuData } from "./data";
import { PageButton } from "./PageButton";
import { AntagsPage } from "./AntagsPage";
import { JobsPage } from "./JobsPage";
import { MainPage } from "./MainPage";
import { SpeciesPage } from "./SpeciesPage";
import { QuirksPage } from "./QuirksPage";
import { LanguagesPage } from "./LanguagesPage";
import { MarkingsPage } from "./MarkingsPage";
import { AugmentsPage } from "./AugmentsPage";
import { BackgroundPage } from "./BackgroundPage";

enum Page {
  Main,
  Markings,
  Augments,
  Languages,
  Background,
  Jobs,
  Antags,
  Species,
  Quirks,
}

const CharacterProfiles = (props: {
  activeSlot: number,
  onClick: (index: number) => void,
  profiles: (string | null)[],
}) => {
  const { profiles } = props;

  return (
    <Stack justify="center" wrap>
      {profiles.map((profile, slot) => (
        <Stack.Item key={slot}>
          <Button
            selected={slot === props.activeSlot}
            onClick={() => {
              props.onClick(slot);
            }} fluid>{profile ?? "New Character"}
          </Button>
        </Stack.Item>
      ))}
    </Stack>
  );
};

export const CharacterPreferenceWindow = (props, context) => {
  const { act, data } = useBackend<PreferencesMenuData>(context);

  const [currentPage, setCurrentPage] = useLocalState(context, "currentPage", Page.Main);

  let pageContents;

  switch (currentPage) {
    case Page.Antags:
      pageContents = <AntagsPage />;
      break;
    case Page.Jobs:
      pageContents = <JobsPage />;
      break;
    case Page.Main:
      pageContents = (<MainPage
        openSpecies={() => setCurrentPage(Page.Species)}
      />);
      break;
    case Page.Species:
      pageContents = (<SpeciesPage
        closeSpecies={() => setCurrentPage(Page.Main)}
      />);
      break;
    case Page.Quirks:
      pageContents = <QuirksPage />;
      break;
    case Page.Languages:
      pageContents = <LanguagesPage />;
      break;
    case Page.Markings:
      pageContents = <MarkingsPage />;
      break;
    case Page.Augments:
      pageContents = <AugmentsPage />;
      break;
    case Page.Background:
      pageContents = <BackgroundPage />;
      break;
    default:
      exhaustiveCheck(currentPage);
  }

  return (
    <Window
      title="Character Preferences"
      width={1000}
      height={770}
      theme="quake"
    >
      <Window.Content scrollable>
        <Stack vertical fill>
          <Stack.Item>
            <CharacterProfiles
              activeSlot={data.active_slot - 1}
              onClick={(slot) => {
                act("change_slot", {
                  slot: slot + 1,
                });
              }}
              profiles={data.character_profiles}
            />
          </Stack.Item>

          {!data.content_unlocked && (
            <Stack.Item align="center">
              Buy BYOND premium for an extra 5 slots!
            </Stack.Item>
          )}
          {!data.donator_rank && (
            <Stack.Item align="center">
              Make cool character
            </Stack.Item>
          )}

          <Stack.Divider />

          <Stack.Item>
            <Stack fill>
              <Stack.Item grow>
                <PageButton
                  currentPage={currentPage}
                  page={Page.Main}
                  setPage={setCurrentPage}
                  otherActivePages={[Page.Species]}
                >
                  General
                </PageButton>
              </Stack.Item>

              <Stack.Item grow>
                <PageButton
                  currentPage={currentPage}
                  page={Page.Markings}
                  setPage={setCurrentPage}
                >
                  Markings
                </PageButton>
              </Stack.Item>

              <Stack.Item grow>
                <PageButton
                  currentPage={currentPage}
                  page={Page.Augments}
                  setPage={setCurrentPage}
                >
                  Augments
                </PageButton>
              </Stack.Item>

              <Stack.Item grow>
                <PageButton
                  currentPage={currentPage}
                  page={Page.Languages}
                  setPage={setCurrentPage}
                >
                  Languages
                </PageButton>
              </Stack.Item>

              <Stack.Item grow>
                <PageButton
                  currentPage={currentPage}
                  page={Page.Background}
                  setPage={setCurrentPage}
                >
                  Background
                </PageButton>
              </Stack.Item>

              <Stack.Item grow>
                <PageButton
                  currentPage={currentPage}
                  page={Page.Jobs}
                  setPage={setCurrentPage}
                >
                  Occupations
                </PageButton>
              </Stack.Item>

              <Stack.Item grow>
                <PageButton
                  currentPage={currentPage}
                  page={Page.Antags}
                  setPage={setCurrentPage}
                >
                  Antagonism
                </PageButton>
              </Stack.Item>
            </Stack>
          </Stack.Item>

          <Stack.Divider />

          <Stack.Item>
            {pageContents}
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
