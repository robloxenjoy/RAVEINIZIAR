import { useBackend } from "../backend";
import { Stack, Box, Tooltip, Button } from '../components';
import { Window } from "../layouts";

const CloserInspection = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    closely_inspected_attribute = [],
  } = data;

  return (
    <Stack
      width="100%"
      height="100%"
      vertical
    >
      <Stack.Item
        mb={0}
        height={closely_inspected_attribute.defaults?.length
          ? "52.5%" : "85%"}
      >
        <Box
          width="100%"
          className="PreferencesMenu__papersplease__header__left">
          <Box
            textAlign="center"
            className="PreferencesMenu__papersplease__header__title"
            style={{
              "font-size": "200%",
            }}>
            <Box>
              {closely_inspected_attribute.name}
              {closely_inspected_attribute.shorthand && (
                <span
                  style={{
                    "font-size": "70%",
                  }}>
                  ({closely_inspected_attribute.shorthand})
                </span>
              )}
            </Box>
            <Tooltip
              content="Stop inspecting"
              position="top"
            >
              <Box
                className="PreferencesMenu__ribbon"
                onClick={() => act("inspect_closely")}
              />
            </Tooltip>
          </Box>
        </Box>
        <Box
          overflowY="hidden"
          width="100%"
          height="100%"
          className={closely_inspected_attribute.defaults?.length
            ? "PreferencesMenu__papersplease__leftbottomless" : "PreferencesMenu__papersplease__left"}
          style={{
            "padding-top": "8px",
            "padding-bottom": "8px",
          }}
        >
          <Stack
            vertical={false}>
            <Stack.Item>
              <Box
                height="128px"
                width="128px"
                className={'attributes_big128x128 ' + closely_inspected_attribute.icon}
              />
            </Stack.Item>
            <Stack.Item
              overflowX="hidden"
              overflowY="hidden"
              width="85%"
              height="128px">
              <Box
                overflowX="hidden"
                overflowY="hidden"
                height="100%"
                width="100%"
                className="PreferencesMenu__papersplease__dotted"
              >
                {closely_inspected_attribute.desc}
                <Box
                  mt={1.5}
                  style={{
                    "font-size": "120%",
                  }}>
                  {closely_inspected_attribute.difficulty && (
                    <Box>
                      <b>Difficulty: </b>
                      {closely_inspected_attribute.difficulty}
                    </Box>
                  )}
                  {closely_inspected_attribute.governing_attribute && (
                    <Box>
                      <b>Governing attribute: </b>
                      {closely_inspected_attribute.governing_attribute}
                    </Box>
                  )}
                </Box>
              </Box>
            </Stack.Item>
          </Stack>
        </Box>
      </Stack.Item>
      {closely_inspected_attribute.defaults?.length && (
        <Stack.Item
          mt={0}
          mb={0}
        >
          <Box
            height={1}
            className="PreferencesMenu__papersplease__gutterhorizontal"
          />
        </Stack.Item>
      )}
      {closely_inspected_attribute.defaults?.length && (
        <Stack.Item
          mt={0}
          height="32.5%"
        >
          <Box
            width="100%"
            className="PreferencesMenu__papersplease__header__leftnoradius">
            <Box
              textAlign="center"
              className="PreferencesMenu__papersplease__header__title"
              style={{
                "font-size": "175%",
              }}>
              Defaults to:
            </Box>
          </Box>
          <Box
            overflowX="hidden"
            overflowY="scroll"
            height="100%"
            className="PreferencesMenu__papersplease__left"
            style={{
              "padding-left": "4px",
              "padding-right": "4px",
              "padding-top": "10px",
              "padding-bottom": "8px",
            }}
          >
            {closely_inspected_attribute.defaults.map(attribute => (
              <Stack.Item
                ml={1}
                mb={2}
                key={attribute.name}
                style={{
                  "font-size": "165%",
                }}
              >
                <Tooltip
                  content={(
                    <Box>
                      {attribute.desc}
                      {attribute.difficulty && (
                        <Box mt={0.5}>
                          [{attribute.difficulty}]
                        </Box>
                      )}
                    </Box>
                  )}
                  position="bottom"
                >
                  <Stack
                    onClick={() => act("inspect_closely", {
                      attribute_name: attribute.name,
                    })}
                  >
                    <Stack.Item
                      vertical={false}>
                      <Box>
                        <Box
                          mr={1}
                          className={'attributes_small16x16 ' + attribute.icon}
                        />
                        {attribute.name}
                        {attribute.shorthand && (
                          <span
                            style={{
                              "font-size": "65%",
                            }}>
                            ({attribute.shorthand})
                          </span>
                        )}
                      </Box>
                    </Stack.Item>
                    <Stack.Item
                      ml={1}>
                      <Box textAlign="right">
                        {attribute.default_value}
                      </Box>
                    </Stack.Item>
                  </Stack>
                </Tooltip>
              </Stack.Item>
            ))}
          </Box>
        </Stack.Item>
      )}
    </Stack>
  );
};

const AttributeStack = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    show_bad_skills,
    skills_by_category = [],
    stats = [],
  } = data;

  return (
    <Stack
      width="100%"
      height="100%"
      vertical={false}
    >
      <Stack.Item
        width="40%"
        height="90%">
        <Box
          width="100%"
          className="PreferencesMenu__papersplease__header__left">
          <Box
            textAlign="center"
            className="PreferencesMenu__papersplease__header__title"
            style={{
              "font-size": "275%",
            }}>
            Stats
          </Box>
        </Box>
        <Box
          width="100%"
          height="52.5%"
          className="PreferencesMenu__papersplease__left"
          style={{
            "padding-left": "4px",
            "padding-right": "4px",
            "padding-top": "8px",
            "font-size": "150%",
          }}
        >
          <Stack
            vertical
          >
            {!stats.length && (
              <Box>
                No stats!
              </Box>
            )}
            {stats.map(stat => (
              <Stack.Item
                mb={2}
                width="100%"
                key={stat.name}
              >
                <Tooltip
                  content={(
                    <Box>
                      {stat.desc}
                    </Box>
                  )}
                  position="bottom">
                  <Stack
                    onClick={() => act("inspect_closely", {
                      attribute_name: stat.name,
                    })}
                  >
                    <Stack.Item
                      width="85%"
                      vertical={false}>
                      <Box
                        width="100%">
                        <Box
                          mr={1}
                          className={'attributes_small16x16 ' + stat.icon}
                        />
                        {stat.name}
                        {stat.shorthand && (
                          <span
                            style={{
                              "font-size": "65%",
                            }}>
                            ({stat.shorthand})
                          </span>
                        )}
                      </Box>
                    </Stack.Item>
                    <Stack.Item>
                      <Box
                        textAlign="right">
                        (
                        <span
                          style={stat.value < stat.raw_value
                            ? "color: #800000;"
                            : (stat.value > stat.raw_value
                              ? "color: #008000;": "")}>
                          {stat.value}
                        </span>
                        /{stat.raw_value})
                      </Box>
                    </Stack.Item>
                  </Stack>
                </Tooltip>
              </Stack.Item>
            ))}
          </Stack>
        </Box>
        <Box
          mt={1}
          width="100%"
          className="PreferencesMenu__papersplease__header__left"
        >
          <Box
            width="100%"
            textAlign="center"
            className="PreferencesMenu__papersplease__header__title"
            style={{
              "font-size": "200%",
            }}
          >
            Show worthless skills?
          </Box>
        </Box>
        <Box
          height="20%"
          width="100%"
          className="PreferencesMenu__papersplease__left"
          style={{
            "padding-left": "25%",
            "padding-right": "4px",
            "padding-top": "8px",
            "font-size": "175%",
          }}
        >
          <Stack
            mt={1}
            width="100%"
            vertical={false}
          >
            <Stack.Item>
              <Stack>
                <Stack.Item
                  mr={0.5}
                  ml={0}
                >
                  <Box
                    mt={0.75}
                    style={{
                      "font-weight": "bold",
                    }}
                  >
                    No
                  </Box>
                </Stack.Item>
                <Stack.Item
                  ml={0}
                >
                  <Tooltip
                    content="Skills you have absolutely no training on will not be shown."
                    position="right">
                    <Button
                      className="PreferencesMenu__Jobs__departments__attributebutton"
                      name="Off"
                      width="32px"
                      height="32px"
                      color={!show_bad_skills ? "paperplease" : "null"}
                      onClick={() => act("disable_bad_skills")}
                      circular
                    />
                  </Tooltip>
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item>
              <Stack>
                <Stack.Item mr={0.5}>
                  <Box
                    mt={0.75}
                    style={{
                      "font-weight": "bold",
                    }}
                  >
                    Yes
                  </Box>
                </Stack.Item>
                <Stack.Item ml={0}>
                  <Tooltip
                    content="Skills you have absolutely no training on will be shown."
                    position="right">
                    <Button
                      className="PreferencesMenu__Jobs__departments__attributebutton"
                      name="On"
                      width="32px"
                      height="32px"
                      color={show_bad_skills ? "paperplease" : "null"}
                      onClick={() => act("enable_bad_skills")}
                      circular
                    />
                  </Tooltip>
                </Stack.Item>
              </Stack>
            </Stack.Item>
          </Stack>
        </Box>
      </Stack.Item>
      <Stack.Item
        width="60%"
        height="85.5%"
      >
        <Box
          width="100%"
          className="PreferencesMenu__papersplease__header__left">
          <Box
            textAlign="center"
            className="PreferencesMenu__papersplease__header__title"
            style={{
              "font-size": "275%",
            }}>
            Skills
          </Box>
        </Box>
        <Box
          width="100%"
          height="100%"
          className="PreferencesMenu__papersplease__left"
          style={{
            "padding-left": "4px",
            "padding-right": "0px",
            "font-size": "150%",
          }}
        >
          <Stack
            width="100%"
            height="100%"
            overflowX="hidden"
            overflowY="scroll"
            vertical>
            {!skills_by_category.length && (
              <Box>
                No skills!
              </Box>
            )}
            {skills_by_category.map(category => (
              <Stack
                vertical
                key={category.name}>
                <Stack.Item>
                  <Box
                    mt={2}
                    style={{
                      "font-size": "140%",
                      "font-weight": "bold",
                      "border-top": "4px dotted rgba(90, 76, 76, 0.7)",
                      "border-bottom": "4px dotted rgba(90, 76, 76, 0.7)",
                    }}>
                    {category.name}
                  </Box>
                </Stack.Item>
                {category.skills.map(skill => (
                  <Stack.Item
                    ml={1}
                    mb={2}
                    width="100%"
                    key={skill.name}
                  >
                    <Tooltip
                      content={(
                        <Box>
                          {skill.desc}
                          {skill.difficulty && (
                            <Box mt={0.5}>
                              [{skill.difficulty}]
                            </Box>
                          )}
                        </Box>
                      )}
                      position="bottom">
                      <Stack
                        onClick={() => act("inspect_closely", {
                          attribute_name: skill.name,
                        })}
                      >
                        <Stack.Item
                          width="85%"
                          vertical={false}>
                          <Box
                            width="100%">
                            <Box
                              mr={1}
                              className={'attributes_small16x16 ' + skill.icon}
                            />
                            {skill.name}
                          </Box>
                        </Stack.Item>
                        <Stack.Item>
                          <Box
                            textAlign="right"
                            mr={2}>
                            (
                            {((skill.value !== null)
                              && (skill.raw_value !== null)) && (
                              <span
                                style={skill.value < skill.raw_value
                                  ? "color: #800000;"
                                  : (skill.value > skill.raw_value
                                    ? "color: #008000;": "")}>
                                {skill.value}
                              </span>
                            ) || (
                              <span>
                                {(skill.value
                                === Number(skill.value)) && (
                                  <span
                                    style={{
                                      'color': '#008000',
                                    }}
                                  >
                                    {skill.value}
                                  </span>
                                )}
                                {(skill.raw_value
                                === Number(skill.raw_value)) && (
                                  <span
                                    style={{
                                      'color': '#800000',
                                    }}
                                  >
                                    {skill.value}
                                  </span>
                                )}
                              </span>
                            )}
                            /{skill.raw_value})
                          </Box>
                        </Stack.Item>
                      </Stack>
                    </Tooltip>
                  </Stack.Item>
                ))}
              </Stack>
            ))}
          </Stack>
        </Box>
      </Stack.Item>
    </Stack>
  );
};

export const AttributeMenu = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    show_bad_skills,
    parent,
    skills_by_category = [],
    stats = [],
    closely_inspected_attribute = [],
  } = data;

  return (
    <Window
      title={parent ? parent + ` Attributes` : `Attributes`}
      width={800}
      height={400}>
      <Window.Content>
        {closely_inspected_attribute?.name && (
          <CloserInspection props={props} context={context} />
        ) || (
          <AttributeStack props={props} context={context} />
        )}
      </Window.Content>
    </Window>
  );
};
