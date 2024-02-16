import { useBackend } from "../../../../../backend";
import { PreferencesMenuData } from "../../../data";
import { Button, Stack } from "../../../../../components";

export const CharacterPreviewType = (props: {
  character_preview_type: string;
  handlePreviewJob: () => void;
  handlePreviewNaked: () => void;
}, context) => {
  const { act, data } = useBackend<PreferencesMenuData>(context);
  return (
    <Stack
      vertical={false}
      fill>
      <Stack.Item
        grow
        fontSize={1.25}
        overflowX="hidden"
        overflowY="hidden"
        textAlign="center"
      >
        <Button
          fluid
          selected={props.character_preview_type === "Job"}
          onClick={props.handlePreviewJob}
        >
          Job
        </Button>
      </Stack.Item>
      <Stack.Item
        grow
        fontSize={1.25}
        overflowX="hidden"
        overflowY="hidden"
        textAlign="center"
      >
        <Button
          fluid
          selected={props.character_preview_type === "Naked"}
          onClick={props.handlePreviewNaked}
        >
          Naked
        </Button>
      </Stack.Item>
    </Stack>
  );
};
