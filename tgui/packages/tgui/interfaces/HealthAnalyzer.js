import { round } from "../../common/math";
import { useBackend, useLocalState } from "../backend";
import { Flex, Stack, Section, LabeledList, ProgressBar, Tabs, Box, BlockQuote, Collapsible, AnimatedNumber } from '../components';
import { Window } from "../layouts";

export const HealthAnalyzer = (props, context) => {
  const { act, data } = useBackend(context);
  const [tabIndex, setTabIndex] = useLocalState(context, 'tabIndex', 'Overall');
  const {
    patient,
  } = data;

  return (
    <Window
      title={`Analyzing ${patient}`}
      width={850}
      height={700}>
      <Window.Content
        scrollable>
        <Tabs
          vertical={false}
          fluid={false}
          textAlign={'center'}>
          <Tabs.Tab
            key={'Overall'}
            selected={tabIndex === 'Overall'}
            onClick={() => setTabIndex('Overall')}>
            Overall
          </Tabs.Tab>
          <Tabs.Tab
            key={'Bodyparts'}
            selected={tabIndex === 'Bodyparts'}
            onClick={() => setTabIndex('Bodyparts')}>
            Bodyparts
          </Tabs.Tab>
          <Tabs.Tab
            key={'Organs'}
            selected={tabIndex === 'Organs'}
            onClick={() => setTabIndex('Organs')}>
            Organs
          </Tabs.Tab>
          <Tabs.Tab
            key={'Diseases'}
            selected={tabIndex === 'Diseases'}
            onClick={() => setTabIndex('Diseases')}>
            Diseases
          </Tabs.Tab>
          <Tabs.Tab
            key={'Psyche'}
            selected={tabIndex === 'Psyche'}
            onClick={() => setTabIndex('Psyche')}>
            Psyche
          </Tabs.Tab>
          <Tabs.Tab
            key={'Chemicals'}
            selected={tabIndex === 'Chemicals'}
            onClick={() => setTabIndex('Chemicals')}>
            Chemicals
          </Tabs.Tab>
        </Tabs>
        {tabIndex === 'Overall' && (
          <OverallScan />
        )}
        {tabIndex === 'Bodyparts' && (
          <BodypartScan />
        )}
        {tabIndex === 'Organs' && (
          <OrganScan />
        )}
        {tabIndex === 'Diseases' && (
          <DiseaseScan />
        )}
        {tabIndex === 'Psyche' && (
          <PsychScan />
        )}
        {tabIndex === 'Chemicals' && (
          <ChemScan />
        )}
      </Window.Content>
    </Window>
  );
};

const OverallScan = (props, context) => {
  const { data } = useBackend(context);
  const {
    advanced,
    species,
    status,
    anencephalic,
    catatonic,
    brain_activity,
    overall_damage,
    oxyloss,
    toxloss,
    cloneloss,
    fireloss,
    bruteloss,
    staminaloss,
    traumatic_shock,
    shock_stage,
    husked,
    disfigured,
    radiation,
    hallucinating,
    cardiac_arrest,
    genetic_stability,
    core_temperature,
    body_temperature,
    timeofdeath,
    blood_name,
    blood_type,
    bleed_rate,
    pulse,
    normal_blood_volume,
    blood_volume,
    blood_volume_perc,
    blood_circulation,
    blood_circulation_perc,
    blood_oxygenation,
    blood_oxygenation_perc,
    icon64,
    funnyquote,
  } = data;

  return (
    <Stack fill>
      <Stack.Item width="65%">
        <BlockQuote
          italic>
          {funnyquote}
        </BlockQuote>
        <Section title={`Blood`}>
          <LabeledList>
            <LabeledList.Item label={`Blood Reagent`}>
              {blood_name}
            </LabeledList.Item>
            <LabeledList.Item label={`Blood Type`}>
              {blood_type}
            </LabeledList.Item>
            <LabeledList.Item label={`Ideal Blood Volume`}>
              <AnimatedNumber value={normal_blood_volume} />cl
            </LabeledList.Item>
            <LabeledList.Item
              label={`Blood Volume`}>
              <ProgressBar
                value={blood_volume_perc/100}
                color={`bad`}>
                <AnimatedNumber value={blood_volume} />cl
                / <AnimatedNumber value={blood_volume_perc} />%
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item
              label={`Blood Circulation`}>
              <ProgressBar
                value={blood_circulation_perc/100}
                color={`bad`}>
                <AnimatedNumber value={blood_circulation} />cl
                / <AnimatedNumber value={blood_circulation_perc} />%
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item
              label={`Blood Oxygenation`}>
              <ProgressBar
                value={blood_oxygenation_perc/100}
                color={`bad`}>
                <AnimatedNumber value={blood_oxygenation} />cl
                / <AnimatedNumber value={blood_oxygenation_perc} />%
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item
              label={`Bleed Rate`}>
              <ProgressBar
                value={advanced ? bleed_rate/10 : (bleed_rate ? 1 : 0)}
                color={"bad"}>
                {advanced
                  ? <AnimatedNumber value={bleed_rate} />
                  : bleed_rate ? "Bleeding" : "Not Bleeding"}
                {advanced
                  ? `cl/s` : null}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label={`Pulse`}>
              {pulse} bpm
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title={`Damage`}>
          <LabeledList>
            <LabeledList.Item label={`Brain Activity`}>
              <ProgressBar
                value={brain_activity/100}
                color={brain_activity >= 50 ? "good" : "bad"}>
                <AnimatedNumber value={brain_activity} />%
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label={`Genetic Stability`}>
              <ProgressBar
                value={genetic_stability/100}
                color={genetic_stability >= 50 ? "good" : "bad"}>
                <AnimatedNumber value={genetic_stability} />%
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label={`Radiation`}>
              <ProgressBar
                value={radiation ? 1 : 0}
                color={radiation ? "bad" : "good"}>
                {radiation ? "Detected" : "Undetected"}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Divider />
            <LabeledList.Item label={`Accumulated Damage`}>
              <ProgressBar
                value={overall_damage/100}
                color="bad">
                <AnimatedNumber value={overall_damage} />
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label={`Brute Damage`}>
              <ProgressBar
                value={bruteloss/100}
                color="bad">
                <AnimatedNumber value={bruteloss} />
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label={`Burn Damage`}>
              <ProgressBar
                value={fireloss/100}
                color="bad">
                <AnimatedNumber value={fireloss} />
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label={`Oxygen Damage`}>
              <ProgressBar
                value={oxyloss/100}
                color="bad">
                <AnimatedNumber value={oxyloss} />
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label={`Cellular Damage`}>
              <ProgressBar
                value={advanced ? cloneloss/100 : (cloneloss ? 1 : 0)}
                color="bad">
                {advanced
                  ? <AnimatedNumber value={cloneloss} />
                  : cloneloss ? "Detected" : "Undetected"}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label={`Toxin Damage`}>
              <ProgressBar
                value={toxloss/100}
                color="bad">
                <AnimatedNumber value={toxloss} />
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label={`Stamina Loss`}>
              <ProgressBar
                value={advanced ? staminaloss/100 : (staminaloss ? 1 : 0)}
                color="bad">
                {advanced
                  ? <AnimatedNumber value={staminaloss} />
                  : staminaloss ? "Detected" : "Undetected"}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label={`Pain`}>
              <ProgressBar
                value={traumatic_shock/100}
                color="bad">
                <AnimatedNumber value={traumatic_shock} />
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label={`Shock`}>
              <ProgressBar
                value={shock_stage/100}
                color="bad">
                <AnimatedNumber value={shock_stage} />
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Stack.Item>
      <Stack.Item width="35%">
        <Box
          my={3.5}
        />
        {(icon64 ? true : false) && (
          <Section
            textAlign={`center`}
            title={species}>
            <Box
              as="img"
              m={0}
              height="100%"
              width="100%"
              src={`data:image/jpeg;base64,${icon64}`}
              style={{
                '-ms-interpolation-mode': 'nearest-neighbor',
              }} />
          </Section>
        )}
        <Section title={`Status`}>
          <Box
            color={status === 'Conscious' ? "good" : (status === "Dead" ? "#e2c1ff" : "bad")}>
            {status}
          </Box>
          {(anencephalic ? true : false) && (
            <Box color="bad">
              {anencephalic}
            </Box>
          )}
          {(cardiac_arrest ? true : false) && (
            <Box color="bad">
              {cardiac_arrest}
            </Box>
          )}
          {(catatonic ? true : false) && (
            <Box color="#e2c1ff">
              {catatonic}
            </Box>
          )}
          {(husked ? true : false) && (
            <Box color="bad">
              {husked}
            </Box>
          )}
          {(disfigured ? true : false) && (
            <Box color="bad">
              {disfigured}
            </Box>
          )}
          {(hallucinating ? true : false) && (
            <Box color="#e2c1ff">
              {hallucinating}
            </Box>
          )}
          {(status === "Dead" && timeofdeath ? true : false) && (
            <Box color="#e2c1ff">
              {`Time of death: ${timeofdeath}`}
            </Box>
          )}
        </Section>
        <Section title={`Temperature`}>
          <LabeledList>
            <LabeledList.Item label="Body Temperature">
              <ProgressBar
                value={1}>
                <AnimatedNumber value={round(body_temperature, 10)} />K
                / <AnimatedNumber value={round(body_temperature-273, 10)} />°C
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Core Temperature">
              <ProgressBar
                value={1}>
                <AnimatedNumber value={round(core_temperature, 10)} />K
                / <AnimatedNumber value={round(core_temperature-273, 10)} />°C
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Stack.Item>
    </Stack>
  );
};

const BodypartScan = (props, context) => {
  const { data } = useBackend(context);
  const {
    advanced,
    bodyparts = [],
  } = data;
  const [bodypartTabIndex, setBodypartTabIndex] = useLocalState(context, 'organTabIndex', bodyparts[0].zone);
  const activeZone = bodyparts.find(bodyzone => {
    return bodyzone.zone === bodypartTabIndex;
  });

  return (
    <Flex>
      <Flex.Item>
        <Tabs
          fill
          vertical>
          {bodyparts.map(bodypart => (
            <Tabs.Tab
              key={bodypart.zone}
              selected={bodypartTabIndex === bodypart.zone}
              onClick={() => setBodypartTabIndex(bodypart.zone)}>
              {bodypart.zone}
            </Tabs.Tab>
          ))}
        </Tabs>
      </Flex.Item>
      <Flex.Item>
        <Section
          title={activeZone.zone}>
          <LabeledList>
            {(activeZone.name === "Missing") && (
              <LabeledList.Item
                color={"bad"}
                label={`Status`}>
                {activeZone.name}
              </LabeledList.Item>
            )}
            {(activeZone.name !== "Missing") && (
              <LabeledList.Item
                label={`Name`}>
                {activeZone.name}
              </LabeledList.Item>
            )}
            {(activeZone.name !== "Missing") && (
              <LabeledList.Item
                label={`Status`}>
                {activeZone.status}
              </LabeledList.Item>
            )}
            {(activeZone.name !== "Missing") && (
              <LabeledList.Item
                label={`Maximum Damage`}>
                {activeZone.max_damage}
              </LabeledList.Item>
            )}
            {(activeZone.name !== "Missing") && (
              <LabeledList.Item
                label={`Overall Damage`}>
                <ProgressBar
                  value={activeZone.overall_damage/activeZone.max_damage}
                  color={`bad`}>
                  <AnimatedNumber value={activeZone.overall_damage} />
                </ProgressBar>
              </LabeledList.Item>
            )}
            {(activeZone.name !== "Missing") && (
              <LabeledList.Item
                label={`Brute Damage`}>
                <ProgressBar
                  value={activeZone.bruteloss/activeZone.max_damage}
                  color={`bad`}>
                  <AnimatedNumber value={activeZone.bruteloss} />
                </ProgressBar>
              </LabeledList.Item>
            )}
            {(activeZone.name !== "Missing") && (
              <LabeledList.Item
                label={`Burn Damage`}>
                <ProgressBar
                  value={activeZone.fireloss/activeZone.max_damage}
                  color={`bad`}>
                  <AnimatedNumber value={activeZone.fireloss} />
                </ProgressBar>
              </LabeledList.Item>
            )}
            {(activeZone.name !== "Missing") && (
              <LabeledList.Item
                label={`Stamina Damage`}>
                {advanced && (
                  <ProgressBar
                    value={activeZone.staminaloss/activeZone.max_stam_damage}
                    color={`bad`}>
                    <AnimatedNumber value={activeZone.staminaloss} />
                  </ProgressBar>
                ) || (
                  <ProgressBar
                    value={activeZone.staminaloss ? 1 : 0}
                    color={`bad`}>
                    {activeZone.staminaloss ? "Detected" : "Undetected"}
                  </ProgressBar>
                )}
              </LabeledList.Item>
            )}
            {(activeZone.name !== "Missing") && (
              <LabeledList.Item
                label={`Pain`}>
                <ProgressBar
                  value={activeZone.traumatic_shock/activeZone.max_pain}
                  color={`bad`}>
                  <AnimatedNumber value={activeZone.traumatic_shock} />
                </ProgressBar>
              </LabeledList.Item>
            )}
            {(activeZone.name !== "Missing") && (
              <LabeledList.Item
                label={`Infection Level`}>
                {advanced && (
                  <ProgressBar
                    value={activeZone.germ_level/100}
                    color={`bad`}>
                    <AnimatedNumber value={activeZone.germ_level} />%
                  </ProgressBar>
                ) || (
                  <ProgressBar
                    value={activeZone.germ_level ? 1 : 0}
                    color={`bad`}>
                    {activeZone.germ_level ? "Infection" : "No Infection"}
                  </ProgressBar>
                )}
              </LabeledList.Item>
            )}
          </LabeledList>
        </Section>
      </Flex.Item>
    </Flex>
  );
};

const OrganScan = (props, context) => {
  const { data } = useBackend(context);
  const {
    advanced,
    bodyparts = [],
  } = data;
  const [organTabIndex, setOrganTabIndex] = useLocalState(context, 'organTabIndex', bodyparts[0].zone);
  const activeZone = bodyparts.find(bodyzone => {
    return bodyzone.zone === organTabIndex;
  });

  return (
    <Flex>
      <Flex.Item>
        <Tabs
          fill
          vertical>
          {bodyparts.map(bodypart => (
            <Tabs.Tab
              key={bodypart.zone}
              selected={organTabIndex === bodypart.zone}
              onClick={() => setOrganTabIndex(bodypart.zone)}>
              {bodypart.zone}
            </Tabs.Tab>
          ))}
        </Tabs>
      </Flex.Item>
      <Flex.Item>
        {!(activeZone.organs.length) && (
          <Section
            fill
            bold
            py={40}
            textAlign={'center'}
            fontSize={2.5}>
            No organs detected.
          </Section>
        )}
        {activeZone.organs.map(organ => (
          <Section
            key={organ.name}
            title={organ.name}>
            <LabeledList>
              <LabeledList.Item
                label={`Name`}>
                {organ.name}
              </LabeledList.Item>
              <LabeledList.Item
                label={`Status`}>
                {organ.status}
              </LabeledList.Item>
              <LabeledList.Item
                label={`Maximum Damage`}>
                {organ.max_damage}
              </LabeledList.Item>
              <LabeledList.Item
                label={`Overall Damage`}
                color={organ.overall_damage !== "Healthy" ? "bad" : "good"}>
                {organ.overall_damage}
              </LabeledList.Item>
              {(advanced ? true : false) && (
                <LabeledList.Item label="Damage">
                  <ProgressBar
                    value={organ.damage/organ.max_damage}
                    color={`bad`}>
                    <AnimatedNumber value={organ.damage} />
                  </ProgressBar>
                </LabeledList.Item>
              )}
              {(advanced ? true : false) && (
                <LabeledList.Item label="Infection Level">
                  <ProgressBar
                    value={organ.germ_level/100}
                    color={`bad`}>
                    <AnimatedNumber value={organ.germ_level} />%
                  </ProgressBar>
                </LabeledList.Item>
              )}
              {(advanced ? false : true) && (
                <LabeledList.Item label="Infection Level">
                  <ProgressBar
                    value={organ.germ_level ? 1 : 0}
                    color={`bad`}>
                    {organ.germ_level ? "Infection" : "No Infection"}
                  </ProgressBar>
                </LabeledList.Item>
              )}
            </LabeledList>
            {(advanced ? true : false) && (
              <Collapsible
                mt={1}
                mx={0.5}
                title={`Efficiencies`}>
                {(organ.efficiencies.length ? true : false) && (
                  <Section
                    ml={0.1}>
                    <LabeledList>
                      {(organ.efficiencies.map(efficiency => (
                        <LabeledList.Item
                          key={efficiency.slot}
                          label={efficiency.slot}>
                          {efficiency.value}
                        </LabeledList.Item>
                      )))}
                    </LabeledList>
                  </Section>
                ) || (
                  <Section
                    fill
                    bold
                    py={2.5}
                    textAlign={'center'}
                    fontSize={2.5}>
                    No efficiencies detected.
                  </Section>
                )}
              </Collapsible>
            )}
          </Section>
        ))}
      </Flex.Item>
    </Flex>
  );
};

const DiseaseScan = (props, context) => {
  const { data } = useBackend(context);
  const {
    diseases = [],
  } = data;

  return (
    <Stack
      fill
      vertical>
      <Stack.Item>
        {diseases.map(disease => (
          <Section
            key={disease.name}
            title={disease.name}>
            <LabeledList>
              <LabeledList.Item label={`Name`}>
                {disease.name}
              </LabeledList.Item>
              <LabeledList.Item label={`Form`}>
                {disease.form}
              </LabeledList.Item>
              <LabeledList.Item label={`Agent`}>
                {disease.agent}
              </LabeledList.Item>
              <LabeledList.Item label={`Spread`}>
                {disease.type}
              </LabeledList.Item>
              <LabeledList.Item label={`Stage`}>
                <ProgressBar
                  value={disease.stage/disease.max_stage}
                  color={`bad`}>
                  <AnimatedNumber value={disease.stage} />
                  / <AnimatedNumber value={disease.max_stage} />
                </ProgressBar>
              </LabeledList.Item>
              <LabeledList.Item label={`Severity`}>
                {disease.severity}
              </LabeledList.Item>
              <LabeledList.Item label={`Hopelessness`}>
                {disease.hopelessness}
              </LabeledList.Item>
              <LabeledList.Item label={`Possible Cure`}>
                {disease.cure}
              </LabeledList.Item>
            </LabeledList>
          </Section>
        ))}
        {(diseases.length ? false : true) && (
          <Section
            fill
            bold
            py={40}
            textAlign={'center'}
            fontSize={2.5}>
            No pathogens detected.
          </Section>
        )}
      </Stack.Item>
    </Stack>
  );
};

const PsychScan = (props, context) => {
  const { data } = useBackend(context);
  const [psychIndex, setPsychIndex] = useLocalState(context, 'psychIndex', 'Brain Traumas');
  const {
    advanced,
    brain_traumas = [],
    major_disabilities = [],
    minor_disabilities = [],
    neutral_disabilities = [],
  } = data;

  return (
    <Stack
      fill
      vertical>
      <Flex>
        <Flex.Item>
          <Tabs
            fill
            vertical>
            <Tabs.Tab
              key={`Brain Traumas`}
              selected={psychIndex === `Brain Traumas`}
              onClick={() => setPsychIndex(`Brain Traumas`)}>
              Brain Traumas
            </Tabs.Tab>
            <Tabs.Tab
              key={`Major Disabilities`}
              selected={psychIndex === `Major Disabilities`}
              onClick={() => setPsychIndex(`Major Disabilities`)}>
              Major Disabilities
            </Tabs.Tab>
            {(advanced ? true : false) && (
              <Tabs.Tab
                key={`Minor Disabilities`}
                selected={psychIndex === `Minor Disabilities`}
                onClick={() => setPsychIndex(`Minor Disabilities`)}>
                Minor Disabilities
              </Tabs.Tab>
            )}
            {(advanced ? true : false) && (
              <Tabs.Tab
                key={`Neutral Disabilities`}
                selected={psychIndex === `Neutral Disabilities`}
                onClick={() => setPsychIndex(`Neutral Disabilities`)}>
                Neutral Disabilities
              </Tabs.Tab>
            )}
          </Tabs>
        </Flex.Item>
        <Flex.Item>
          {(psychIndex === `Brain Traumas`) && (
            <Stack.Item>
              {brain_traumas.map(trauma => (
                <Section
                  key={trauma.name}
                  title={trauma.name}>
                  <LabeledList>
                    <LabeledList.Item
                      label={`Name`}>
                      {trauma.name}
                    </LabeledList.Item>
                    <LabeledList.Item
                      label={`Description`}>
                      {trauma.scan_desc}
                    </LabeledList.Item>
                    <LabeledList.Item
                      label={`Severity`}>
                      {trauma.resilience}
                    </LabeledList.Item>
                  </LabeledList>
                </Section>
              ))}
              {(brain_traumas.length ? false : true) && (
                <Section
                  fill
                  bold
                  py={40}
                  px={16.5}
                  textAlign={'center'}
                  fontSize={2.5}>
                  No brain traumas detected.
                </Section>
              )}
            </Stack.Item>
          )}
          {(psychIndex === `Major Disabilities`) && (
            <Stack.Item>
              {major_disabilities.map(disability => (
                <Section
                  key={disability.name}
                  title={disability.name}>
                  <LabeledList>
                    <LabeledList.Item
                      label={`Name`}>
                      {disability.name}
                    </LabeledList.Item>
                    <LabeledList.Item
                      label={`Description`}>
                      {disability.scan_desc}
                    </LabeledList.Item>
                  </LabeledList>
                </Section>
              ))}
              {(major_disabilities.length ? false : true) && (
                <Section
                  fill
                  bold
                  py={40}
                  px={12}
                  textAlign={'center'}
                  fontSize={2.5}>
                  No major disabilities detected.
                </Section>
              )}
            </Stack.Item>
          )}
          {(psychIndex === `Minor Disabilities`) && (
            <Stack.Item>
              {advanced ? minor_disabilities.map(disability => (
                <Section
                  key={disability.name}
                  title={disability.name}>
                  <LabeledList>
                    <LabeledList.Item
                      label={`Name`}>
                      {disability.name}
                    </LabeledList.Item>
                    <LabeledList.Item
                      label={`Description`}>
                      {disability.scan_desc}
                    </LabeledList.Item>
                  </LabeledList>
                </Section>
              )) : null}
              {(advanced && minor_disabilities.length ? false : true) && (
                <Section
                  fill
                  bold
                  py={40}
                  px={12}
                  textAlign={'center'}
                  fontSize={2.5}>
                  No minor disabilities detected.
                </Section>
              )}
            </Stack.Item>
          )}
          {(psychIndex === `Neutral Disabilities`) && (
            <Stack.Item>
              {advanced ? neutral_disabilities.map(disability => (
                <Section
                  key={disability.name}
                  title={disability.name}>
                  <LabeledList>
                    <LabeledList.Item
                      label={`Name`}>
                      {disability.name}
                    </LabeledList.Item>
                    <LabeledList.Item
                      label={`Description`}>
                      {disability.scan_desc}
                    </LabeledList.Item>
                  </LabeledList>
                </Section>
              )) : null}
              {(advanced && neutral_disabilities.length ? false : true) && (
                <Section
                  fill
                  bold
                  py={40}
                  px={10.25}
                  textAlign={'center'}
                  fontSize={2.5}>
                  No neutral disabilities detected.
                </Section>
              )}
            </Stack.Item>
          )}
        </Flex.Item>
      </Flex>
    </Stack>
  );
};

const ChemScan = (props, context) => {
  const { data } = useBackend(context);
  const {
    advanced,
    blood_reagents = [],
    stomach_reagents = [],
    intestine_reagents = [],
    bladder_reagents = [],
    addictions = [],
  } = data;

  return (
    <Stack
      fill
      vertical>
      <Collapsible
        title={`Bloodstream Reagents`}>
        {blood_reagents.map(reagent => (
          <Section
            key={reagent.name}
            title={reagent.name}>
            <LabeledList>
              <LabeledList.Item
                label={`Name`}>
                {reagent.name}
              </LabeledList.Item>
              <LabeledList.Item
                label={`Volume`}>
                <AnimatedNumber value={reagent.volume} />u
              </LabeledList.Item>
              <LabeledList.Item
                color={reagent.overdosing ? "bad" : "good"}
                label={`Overdosing`}>
                {reagent.overdosing ? "Overdosing" : "Not Overdosing"}
              </LabeledList.Item>
            </LabeledList>
          </Section>
        ))}
        {(blood_reagents.length ? false : true) && (
          <Section
            fill
            bold
            py={2.5}
            textAlign={'center'}
            fontSize={2.5}>
            No reagents detected.
          </Section>
        )}
      </Collapsible>
      <Collapsible
        title={`Stomach Reagents`}>
        {stomach_reagents.map(reagent => (
          <Section
            key={reagent.name}
            title={reagent.name}>
            <LabeledList>
              <LabeledList.Item
                label={`Name`}>
                {reagent.name}
              </LabeledList.Item>
              <LabeledList.Item
                label={`Volume`}>
                <AnimatedNumber value={reagent.volume} />u
              </LabeledList.Item>
              <LabeledList.Item
                color={reagent.overdosing ? "bad" : "good"}
                label={`Overdosing`}>
                {reagent.overdosing ? "Overdosing" : "Not Overdosing"}
              </LabeledList.Item>
            </LabeledList>
          </Section>
        ))}
        {(stomach_reagents.length ? false : true) && (
          <Section
            fill
            bold
            py={2.5}
            textAlign={'center'}
            fontSize={2.5}>
            No reagents detected.
          </Section>
        )}
      </Collapsible>
      <Collapsible
        title={`Intestines Reagents`}>
        {intestine_reagents.map(reagent => (
          <Section
            key={reagent.name}
            title={reagent.name}>
            <LabeledList>
              <LabeledList.Item
                label={`Name`}>
                {reagent.name}
              </LabeledList.Item>
              <LabeledList.Item
                label={`Volume`}>
                <AnimatedNumber value={reagent.volume} />u
              </LabeledList.Item>
              <LabeledList.Item
                color={reagent.overdosing ? "bad" : "good"}
                label={`Overdosing`}>
                {reagent.overdosing ? "Overdosing" : "Not Overdosing"}
              </LabeledList.Item>
            </LabeledList>
          </Section>
        ))}
        {(intestine_reagents.length ? false : true) && (
          <Section
            fill
            bold
            py={2.5}
            textAlign={'center'}
            fontSize={2.5}>
            No reagents detected.
          </Section>
        )}
      </Collapsible>
      <Collapsible
        title={`Bladder Reagents`}>
        {bladder_reagents.map(reagent => (
          <Section
            key={reagent.name}
            title={reagent.name}>
            <LabeledList>
              <LabeledList.Item
                label={`Name`}>
                {reagent.name}
              </LabeledList.Item>
              <LabeledList.Item
                label={`Volume`}>
                <AnimatedNumber value={reagent.volume} />u
              </LabeledList.Item>
              <LabeledList.Item
                color={reagent.overdosing ? "bad" : "good"}
                label={`Overdosing`}>
                {reagent.overdosing ? "Overdosing" : "Not Overdosing"}
              </LabeledList.Item>
            </LabeledList>
          </Section>
        ))}
        {(bladder_reagents.length ? false : true) && (
          <Section
            fill
            bold
            py={2.5}
            textAlign={'center'}
            fontSize={2.5}>
            No reagents detected.
          </Section>
        )}
      </Collapsible>
      <Collapsible
        title={`Addictions`}>
        {addictions.map(addiction => (
          <Section
            key={addiction.name}
            title={addiction.name}>
            <LabeledList>
              <LabeledList.Item
                label={`Name`}>
                {addiction.name}
              </LabeledList.Item>
              {(advanced ? true : false && (
                <LabeledList.Item
                  label={`Addiction Level`}>
                  <ProgressBar
                    value={addiction.addiction_points/1000}
                    color={`bad`}>
                    <AnimatedNumber
                      value={round(addiction.addiction_points/10, 1)} />%
                  </ProgressBar>
                </LabeledList.Item>
              ))}
            </LabeledList>
          </Section>
        ))}
        {(addictions.length ? false : true) && (
          <Section
            fill
            bold
            py={2.5}
            textAlign={'center'}
            fontSize={2.5}>
            No addictions detected.
          </Section>
        )}
      </Collapsible>
    </Stack>
  );
};
