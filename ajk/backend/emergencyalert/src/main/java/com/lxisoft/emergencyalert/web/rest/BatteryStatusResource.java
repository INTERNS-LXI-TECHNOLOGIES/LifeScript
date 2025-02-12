package com.lxisoft.emergencyalert.web.rest;

import com.lxisoft.emergencyalert.repository.BatteryStatusRepository;
import com.lxisoft.emergencyalert.service.BatteryStatusService;
import com.lxisoft.emergencyalert.service.dto.BatteryStatusDTO;
import com.lxisoft.emergencyalert.web.rest.errors.BadRequestAlertException;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import tech.jhipster.web.util.HeaderUtil;
import tech.jhipster.web.util.PaginationUtil;
import tech.jhipster.web.util.ResponseUtil;

/**
 * REST controller for managing {@link com.lxisoft.emergencyalert.domain.BatteryStatus}.
 */
@RestController
@RequestMapping("/api/battery-statuses")
public class BatteryStatusResource {

    private static final Logger LOG = LoggerFactory.getLogger(BatteryStatusResource.class);

    private static final String ENTITY_NAME = "batteryStatus";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final BatteryStatusService batteryStatusService;

    private final BatteryStatusRepository batteryStatusRepository;

    public BatteryStatusResource(BatteryStatusService batteryStatusService, BatteryStatusRepository batteryStatusRepository) {
        this.batteryStatusService = batteryStatusService;
        this.batteryStatusRepository = batteryStatusRepository;
    }

    /**
     * {@code POST  /battery-statuses} : Create a new batteryStatus.
     *
     * @param batteryStatusDTO the batteryStatusDTO to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new batteryStatusDTO, or with status {@code 400 (Bad Request)} if the batteryStatus has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<BatteryStatusDTO> createBatteryStatus(@Valid @RequestBody BatteryStatusDTO batteryStatusDTO)
        throws URISyntaxException {
        LOG.debug("REST request to save BatteryStatus : {}", batteryStatusDTO);
        if (batteryStatusDTO.getId() != null) {
            throw new BadRequestAlertException("A new batteryStatus cannot already have an ID", ENTITY_NAME, "idexists");
        }
        batteryStatusDTO = batteryStatusService.save(batteryStatusDTO);
        return ResponseEntity.created(new URI("/api/battery-statuses/" + batteryStatusDTO.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, batteryStatusDTO.getId().toString()))
            .body(batteryStatusDTO);
    }

    /**
     * {@code PUT  /battery-statuses/:id} : Updates an existing batteryStatus.
     *
     * @param id the id of the batteryStatusDTO to save.
     * @param batteryStatusDTO the batteryStatusDTO to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated batteryStatusDTO,
     * or with status {@code 400 (Bad Request)} if the batteryStatusDTO is not valid,
     * or with status {@code 500 (Internal Server Error)} if the batteryStatusDTO couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<BatteryStatusDTO> updateBatteryStatus(
        @PathVariable(value = "id", required = false) final Long id,
        @Valid @RequestBody BatteryStatusDTO batteryStatusDTO
    ) throws URISyntaxException {
        LOG.debug("REST request to update BatteryStatus : {}, {}", id, batteryStatusDTO);
        if (batteryStatusDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, batteryStatusDTO.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!batteryStatusRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        batteryStatusDTO = batteryStatusService.update(batteryStatusDTO);
        return ResponseEntity.ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, batteryStatusDTO.getId().toString()))
            .body(batteryStatusDTO);
    }

    /**
     * {@code PATCH  /battery-statuses/:id} : Partial updates given fields of an existing batteryStatus, field will ignore if it is null
     *
     * @param id the id of the batteryStatusDTO to save.
     * @param batteryStatusDTO the batteryStatusDTO to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated batteryStatusDTO,
     * or with status {@code 400 (Bad Request)} if the batteryStatusDTO is not valid,
     * or with status {@code 404 (Not Found)} if the batteryStatusDTO is not found,
     * or with status {@code 500 (Internal Server Error)} if the batteryStatusDTO couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<BatteryStatusDTO> partialUpdateBatteryStatus(
        @PathVariable(value = "id", required = false) final Long id,
        @NotNull @RequestBody BatteryStatusDTO batteryStatusDTO
    ) throws URISyntaxException {
        LOG.debug("REST request to partial update BatteryStatus partially : {}, {}", id, batteryStatusDTO);
        if (batteryStatusDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, batteryStatusDTO.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!batteryStatusRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<BatteryStatusDTO> result = batteryStatusService.partialUpdate(batteryStatusDTO);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, batteryStatusDTO.getId().toString())
        );
    }

    /**
     * {@code GET  /battery-statuses} : get all the batteryStatuses.
     *
     * @param pageable the pagination information.
     * @param filter the filter of the request.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of batteryStatuses in body.
     */
    @GetMapping("")
    public ResponseEntity<List<BatteryStatusDTO>> getAllBatteryStatuses(
        @org.springdoc.core.annotations.ParameterObject Pageable pageable,
        @RequestParam(name = "filter", required = false) String filter
    ) {
        if ("child-is-null".equals(filter)) {
            LOG.debug("REST request to get all BatteryStatuss where child is null");
            return new ResponseEntity<>(batteryStatusService.findAllWhereChildIsNull(), HttpStatus.OK);
        }
        LOG.debug("REST request to get a page of BatteryStatuses");
        Page<BatteryStatusDTO> page = batteryStatusService.findAll(pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(ServletUriComponentsBuilder.fromCurrentRequest(), page);
        return ResponseEntity.ok().headers(headers).body(page.getContent());
    }

    /**
     * {@code GET  /battery-statuses/:id} : get the "id" batteryStatus.
     *
     * @param id the id of the batteryStatusDTO to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the batteryStatusDTO, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<BatteryStatusDTO> getBatteryStatus(@PathVariable("id") Long id) {
        LOG.debug("REST request to get BatteryStatus : {}", id);
        Optional<BatteryStatusDTO> batteryStatusDTO = batteryStatusService.findOne(id);
        return ResponseUtil.wrapOrNotFound(batteryStatusDTO);
    }

    /**
     * {@code DELETE  /battery-statuses/:id} : delete the "id" batteryStatus.
     *
     * @param id the id of the batteryStatusDTO to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteBatteryStatus(@PathVariable("id") Long id) {
        LOG.debug("REST request to delete BatteryStatus : {}", id);
        batteryStatusService.delete(id);
        return ResponseEntity.noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}
